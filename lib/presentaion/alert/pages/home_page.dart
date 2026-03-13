class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bouton SOS Circulaire
            InkWell(
              onTap: () => context.read<AlertCubit>().triggerEmergency("SOS Button Pressed"),
              child: Container(
                width: 200, height: 200,
                decoration: BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.5), blurRadius: 20)]
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.white, size: 40),
                    Text("Alert", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            // Bouton Report Incident
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/report'),
              icon: const Icon(Icons.warning),
              label: const Text("Report an Incident"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: const Size(250, 60)),
            ),
          ],
        ),
      ),
    );
  }
}