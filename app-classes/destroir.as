function destroir(alvo, gbclear) {
	while (alvo.numChildren > 0) {
		alvo.removeChildAt(0);
	}
	if (gbclear == true) {
		System.gc();
	}
};