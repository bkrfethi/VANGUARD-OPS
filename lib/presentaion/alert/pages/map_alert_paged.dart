class MapAlertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Carte Google Maps (40% de l'écran)
          Positioned(
            top: 50, left: 20, right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 300,
                child: GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(22.5726, 88.3639), zoom: 15)),
              ),
            ),
          ),
          // Infos d'alerte en bas
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildActionTile("Location", "Sharing Location...", Icons.fullscreen_exit),
                  _buildActionTile("Live Footage", "Recording Video...", Icons.videocam),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.read<AlertCubit>().cancelAlert(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: const CircleBorder(), padding: const EdgeInsets.all(24)),
                    child: const Icon(Icons.close, size: 30),
                  ),
                  const Text("Cancel Alert", style: TextStyle(color: Colors.white, height: 2)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}