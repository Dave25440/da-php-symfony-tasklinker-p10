<?php

namespace App\Repository;

use App\Entity\Employee;
use App\Entity\Project;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Project>
 */
class ProjectRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Project::class);
    }

    public function findActive(): array
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.archive = :archive')
            ->setParameter('archive', false)
            ->getQuery()
            ->getResult()
        ;
    }

    public function findActiveById(int $id): ?Project
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.id = :id')
            ->andWhere('p.archive = :archive')
            ->setParameter('id', $id)
            ->setParameter('archive', false)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }

    public function findActiveByEmployee(Employee $employee): array
    {
        return $this->createQueryBuilder('p')
            ->join('p.employees', 'e')
            ->andWhere('e = :employee')
            ->andWhere('p.archive = :archive')
            ->setParameter('employee', $employee)
            ->setParameter('archive', false)
            ->getQuery()
            ->getResult()
        ;
    }

//    /**
//     * @return Project[] Returns an array of Project objects
//     */
//    public function findByExampleField($value): array
//    {
//        return $this->createQueryBuilder('p')
//            ->andWhere('p.exampleField = :val')
//            ->setParameter('val', $value)
//            ->orderBy('p.id', 'ASC')
//            ->setMaxResults(10)
//            ->getQuery()
//            ->getResult()
//        ;
//    }

//    public function findOneBySomeField($value): ?Project
//    {
//        return $this->createQueryBuilder('p')
//            ->andWhere('p.exampleField = :val')
//            ->setParameter('val', $value)
//            ->getQuery()
//            ->getOneOrNullResult()
//        ;
//    }
}
