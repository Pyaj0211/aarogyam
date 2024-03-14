import 'package:aarogyam/doctor/data/models/doctor_model.dart';
import 'package:aarogyam/patient/logic/bloc/digital_bloc.dart';
import 'package:aarogyam/patient/views/screens/session_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SlotScreen extends StatelessWidget {
  const SlotScreen({super.key, required this.doctorModel});
  final DoctorModel doctorModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slots for meeting"),
      ),
      body: BlocBuilder<DigitalBloc, DigitalState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.error.isNotEmpty) {
            return Center(
              child: Text(state.error),
            );
          } else if (state.sessionData.isEmpty) {
            return const Center(
              child: Text("You have't session."),
            );
          }

          return ListView.builder(
              itemCount: state.sessionData.length,
              itemBuilder: ((context, index) {
                final data = state.sessionData[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (context) => DigitalBloc(),
                          child: SessionUserDetailScreen(
                            data: data,
                            doctorModel: doctorModel,
                          ),
                        ),
                      ),
                    );
                  },
                  title: Text(data.option ?? ""),
                  subtitle:
                      Text("${DateFormat("dd MMM yyyy").format(data.meetingTime!.toDate())} Meetings"),
                  trailing: Text("Fees \$${data.price ?? ""}"),
                );
              }));
        },
      ),
    );
  }
}
