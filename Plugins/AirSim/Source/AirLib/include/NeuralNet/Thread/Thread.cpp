
#include "Thread.h"

namespace msr {
	namespace airlib {
		//���ݰ���ʼ��
		DataPack dataPack;

		//UDP��ʼ��
		UdpSever udpSever;

		DWORD WINAPI ThreadReceive(LPVOID lpParam)
		{
			while (1)
			{
				//printf("Receive Data...\n");
				udpSever.ReceiveData(udpSever.RecvBuf, &udpSever.RecvLen);//���ݽ���
				dataPack.PackAnalyze(udpSever.RecvBuf, udpSever.RecvLen, &udpSever.RecvOutput);//���ݷ���

				//Sleep(100);																				
																						
			}
			return 0;
		}


	}
}


