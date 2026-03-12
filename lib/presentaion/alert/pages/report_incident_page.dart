// À mettre dans ton build de page
BlocConsumer<AlertCubit, AlertState>(
  listener: (context, state) {
    if (state is AlertSuccess) { /* Naviguer vers la carte */ }
  },
  builder: (context, state) {
    final isTimer = state is AlertTimerInProgress;
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => isTimer 
            ? context.read<AlertCubit>().cancelAlert() 
            : context.read<AlertCubit>().triggerEmergency("User Alert"),
          style: ElevatedButton.styleFrom(
            backgroundColor: isTimer ? Colors.black : Colors.red,
            minimumSize: const Size(double.infinity, 60),
          ),
          child: Text(isTimer ? "CANCEL (${(state as AlertTimerInProgress).secondsLeft}s)" : "REPORT INCIDENT"),
        ),
      ],
    );
  },
)