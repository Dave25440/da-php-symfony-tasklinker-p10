<?php

namespace App\Security\Voter;

use App\Entity\Employee;
use App\Entity\Project;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Authorization\Voter\Voter;

class ProjectVoter extends Voter
{
    public function __construct(
        private Security $security,
    ) {}

    protected function supports(string $attribute, mixed $subject): bool
    {
        return 'project.employees' === $attribute && $subject instanceof Project;
    }

    protected function voteOnAttribute(string $attribute, mixed $subject, TokenInterface $token): bool
    {
        if ($this->security->isGranted('ROLE_ADMIN')) {
            return true;
        }

        $user = $token->getUser();

        if (!$user instanceof Employee) {
            return false;
        }

        /** @var Project $subject */
        return $subject->getEmployees()->contains($user);
    }
}
