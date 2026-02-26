<?php

namespace App\Form;

use App\Entity\Employee;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Validator\Constraints\Regex;

class RegistrationFormType extends AbstractType
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
                'label' => 'E-mail',
            ])
            ->add('plainPassword', RepeatedType::class, [
                'type' => PasswordType::class,
                'first_options'  => ['label' => 'Mot de passe'],
                'second_options' => ['label' => 'Confirmation mot de passe'],
                'invalid_message' => 'Les deux mots de passe doivent correspondre.',
                                // instead of being set onto the object directly,
                // this is read and encoded in the controller
                'mapped' => false,
                'attr' => ['autocomplete' => 'new-password'],
                'constraints' => [
                    new NotBlank(
                        message: 'Veuillez saisir un mot de passe.',
                    ),
                    new Length(
                        min: 8,
                        minMessage: 'Votre mot de passe doit contenir au moins {{ limit }} caractères.',
                        max: 32,
                        maxMessage: 'Votre mot de passe ne doit pas dépasser {{ limit }} caractères.',
                    ),
                    new Regex([
                        'pattern' => '/^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).{8,32}$/',
                        'message' => 'Votre mot de passe doit contenir entre 8 et 32 caractères dont un chiffre, une minuscule, une majuscule et un caractère spécial, sans espaces.',
                    ]),
                ],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Employee::class,
        ]);
    }
}
