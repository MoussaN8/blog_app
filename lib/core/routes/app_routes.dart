import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String login = "/logIn";
  static const String signUp = "/signUp";
  static const String addNewBlog = "/addNewBlog";
  static const String blogPage = "/blogPage";
  static const String blogViewer = "/blogViewer";
  static Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    signUp: (context) => const SignUpPage(),
    blogPage: (context) => const BlogPage(),
    addNewBlog: (context) => const AddNewBlog(),
    
    
  };
}
