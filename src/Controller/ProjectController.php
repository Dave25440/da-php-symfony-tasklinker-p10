<?php

namespace App\Controller;

use App\Entity\Project;
use App\Form\ProjectType;
use App\Repository\ProjectRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

final class ProjectController extends AbstractController
{
    public function __construct(
        private ProjectRepository $projectRepository,
        private EntityManagerInterface $manager,
    ) {}

    #[Route('/', name: 'app_home', methods: ['GET'])]
    public function index(): Response
    {
        if ($this->isGranted('ROLE_ADMIN')) {
            $projects = $this->projectRepository->findActive();
        } else {
            $projects = $this->projectRepository->findActiveByEmployee($this->getUser());
        }

        return $this->render('project/index.html.twig', [
            'projects' => $projects,
        ]);
    }

    #[Route('/project/{id}', name: 'app_project', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function show(int $id): Response
    {
        $project = $this->projectRepository->findActiveById($id);

        if (!$project) {
            throw $this->createNotFoundException('Projet introuvable.');
        } else {
            $this->denyAccessUnlessGranted('project.employees', $project);
        }

        $tasksToDo = [];
        $tasksDoing = [];
        $tasksDone = [];

        foreach ($project->getTasks() as $task) {
            switch ($task->getStatus()->value) {
                case 'to_do':
                    $tasksToDo[] = $task;
                    break;
                case 'doing':
                    $tasksDoing[] = $task;
                    break;
                case 'done':
                    $tasksDone[] = $task;
                    break;
            }
        }

        return $this->render('project/show.html.twig', [
            'project' => $project,
            'tasksToDo' => $tasksToDo,
            'tasksDoing' => $tasksDoing,
            'tasksDone' => $tasksDone,
        ]);
    }

    #[IsGranted('ROLE_ADMIN')]
    #[Route('/project/new', name: 'app_project_new', methods: ['GET', 'POST'])]
    #[Route('/project/{id}/edit', name: 'app_project_edit', requirements: ['id' => '\d+'], methods: ['GET', 'POST'])]
    public function new(?Project $project, Request $request): Response
    {
        if (!$project && $request->attributes->get('id')) {
            throw $this->createNotFoundException('Projet introuvable.');
        }

        $project ??= new Project();
        $form = $this->createForm(ProjectType::class, $project);

        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->manager->persist($project);
            $this->manager->flush();

            return $this->redirectToRoute('app_project', ['id' => $project->getId()]);
        }

        return $this->render('project/new.html.twig', [
            'form' => $form,
            'project' => $project,
            'edit' => $project->getId() !== null,
        ]);
    }

    #[IsGranted('ROLE_ADMIN')]
    #[Route('/project/{id}/archive', name: 'app_project_archive', requirements: ['id' => '\d+'], methods: ['GET', 'POST'])]
    public function archive(?Project $project): Response
    {
        if (!$project) {
            throw $this->createNotFoundException('Projet introuvable.');
        }

        $project->setArchive(false);
        $this->manager->flush();

        return $this->redirectToRoute('app_home');
    }
}
