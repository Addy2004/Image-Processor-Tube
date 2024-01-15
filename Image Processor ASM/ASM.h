#ifndef ASM_ASM
#define ASM_ASM

extern "C" void ASMAdjustBrightness(
	unsigned char* bmpDataScan0,
	unsigned char* bmpOrignial,
	short value,
	int imageSizeinBytes
);

#endif