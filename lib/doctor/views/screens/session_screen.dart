import 'package:aarogyam/doctor/data/services/doctor_database_services.dart';
import 'package:aarogyam/doctor/logic/bloc/session_bloc/session_bloc.dart';
import 'package:aarogyam/doctor/views/screens/session_details_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SessionBloc()..add(OnGetSessionData()),
      child: const _SessionScreen(),
    );
  }
}

class _SessionScreen extends StatelessWidget {
  const _SessionScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          if(state.isLoading){
            return const Center(child: CircularProgressIndicator(),);
          }else if(state.error.isNotEmpty){
            return Center(child: Text(state.error),);
          }else if(state.sessionData.isEmpty){
            return const Center(child: Text("You have't session."),);
          }
         
          return ListView.builder(
              itemCount: state.sessionData.length,
              itemBuilder: (context, index) {
                 final data = state.sessionData[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SessionDetailScreen(
                          data: data,
                        ),
                      ),
                    );
                  },
                  title: Text(data.option ?? ""),
                  subtitle: Text("${DateFormat("dd MMM yyyy").format(data.meetingTime!.toDate())} Meetings"),
                  trailing: Text("\$${data.price ?? "" }"),
                );
              });
        },
      ),
    );
  }
}
