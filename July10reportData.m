%first, import july11sxdata and july11sydata

findWeightsJuly10Parse

[weight1 summary1 ex1] = findWeightsGEN('original',data_standard,data_light,data_heavy,arrayXPos);
[weight2 summary2 ex2] = findWeightsGEN('originalnonneg',data_standard,data_light,data_heavy,arrayXPos);

[weight3 summary3 ex3] = findWeightsGEN('norm',data_standard,data_light,data_heavy,arrayXPos);

[weight4 summary4 ex4] = findWeightsGEN('normnonneg',data_standard,data_light,data_heavy,arrayXPos);
[weight5 summary5 ex5] = findWeightsGEN('eigen',data_standard,data_light,data_heavy,arrayXPos);


sum1 = [summary1; summary2; summary3; summary4; summary5]



figure(1)
visualizeFeet(1,transpose(ex4(1:40)),'m','Forces')
figure(2)
visualizeFeet(1,abs(weight4.*transpose(arrayXPos)),'t','Weight*Position')
figure(3)
visualizeFeet(1,weight4,'t','Weight',ex4(41),[ex4(42) 0])%ex4(28)])
figure(4)
visualizeFeet(1,abs(transpose(ex4(1:40)).*weight4.*transpose(arrayXPos)),'b','Forces*Weight*Position',ex4(41),[ex4(42) 0])%ex4(28)])
figure(5)
visualizeFeet(1,abs(transpose(arrayXPos)),'t','XPos',ex4(41),[ex4(42) 0])%ex4(28)])