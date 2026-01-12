import 'dart:io';

import 'package:blog_app/core/common/cubits/cubit/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/routes/app_routes.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/core/utils/choisir_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_form.dart';
import 'package:blog_app/features/blog/presentation/widgets/listes_elements.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlog extends StatefulWidget {
  const AddNewBlog({super.key});

  @override
  State<AddNewBlog> createState() => _AddNewBlogState();
}

class _AddNewBlogState extends State<AddNewBlog> {
  final titreController = TextEditingController();
  final contenuController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? itemSelected;
  File? image;

  @override
  void dispose() {
    titreController.dispose();
    contenuController.dispose();
    super.dispose();
  }

  void imageSelectionne() async {
    final imageChoisi = await choisirImage();
    setState(() {
      if (imageChoisi != null) {
        image = imageChoisi;
      }
    });
  }

  void validateForm() {
    final userId =
        (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    context.read<BlogBloc>().add(
      UploadBlogEvent(
        titre: titreController.text.trim(),
        contenu: contenuController.text.trim(),
        imageUrl: image!,
        userId: userId,
        theme: itemSelected!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un nouveau blog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState!.validate() &&
                  itemSelected!.isNotEmpty &&
                  image != null &&
                  itemSelected != null) {
                validateForm();
              } else {
                showSnackBar(context, 'Veuillez remplir tous les champs');
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.message);
          } else if (state is BlogSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.blogPage,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  image != null
                      ? GestureDetector(
                          onTap: () {
                            imageSelectionne();
                          },
                          child: Image.file(image!, fit: BoxFit.cover),
                        )
                      : GestureDetector(
                          onTap: () {
                            imageSelectionne();
                          },

                          child: DottedBorder(
                            options: const RectDottedBorderOptions(
                              dashPattern: [12, 4],
                              color: AppPallete.borderColor,
                              strokeWidth: 4,
                            ),
                            child: SizedBox(
                              height: 140,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.folder_open, size: 50),
                                  SizedBox(height: 20),
                                  Text(
                                    'Ajouter une image',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Filtres(
                          onSelected: (value) {
                            setState(() {
                              itemSelected = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  BlogForm(titre: 'Titre', controller: titreController),
                  SizedBox(height: 20),
                  Expanded(
                    child: BlogForm(
                      titre: 'Contenu',
                      controller: contenuController,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
