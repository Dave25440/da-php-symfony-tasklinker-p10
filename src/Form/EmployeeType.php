<?php

namespace App\Form;

use App\Entity\Employee;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\CallbackTransformer;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\OptionsResolver\OptionsResolver;

class EmployeeType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('lastname', TextType::class, [
                'label' => 'Nom',
            ])
            ->add('firstname', TextType::class, [
                'label' => 'Prénom',
            ])
            ->add('email', TextType::class, [
                'label' => 'Email',
            ])
            ->add('start', DateType::class, [
                'label' => "Date d'entrée",
                'input' => 'datetime_immutable',
                'widget' => 'single_text',
            ])
            ->add('status', TextType::class, [
                'label' => 'Statut',
            ])
            ->add('roles', ChoiceType::class, [
                'label' => 'Rôle',
                'choices' => [
                    'Collaborateur' => 'ROLE_USER',
                    'Chef de projet' => 'ROLE_ADMIN',
                ],
                'multiple' => false,
            ])
            ->get('roles')
            ->addModelTransformer(new CallbackTransformer(

                // Transforme le tableau en chaîne (avant l'affichage du formulaire)
                function ($rolesArray) {
                    return is_array($rolesArray) && count($rolesArray) > 0 ? $rolesArray[0] : null;
                },

                // Transforme la chaîne du formulaire en tableau (après la soumission du formulaire)
                function ($roleString) {
                    return $roleString ? [$roleString] : [];
                }
            ))
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Employee::class,
        ]);
    }
}
