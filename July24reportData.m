%first, import july11sxdata and july11sydata

findWeightsJuly23Parse_strip


[weight1 summary1 ex1] = findWeightsGEN('original',data_standardx,data_lightx,data_heavyx,stripXPos,data_standardy,data_lighty,data_heavyy,stripYPos,0);

[weight2 summary2 ex2] = findWeightsGEN('originalnonneg',data_standardx,data_lightx,data_heavyx,stripXPos,data_standardy,data_lighty,data_heavyy,stripYPos,0);

[weight3 summary3 ex3] = findWeightsGEN('norm',data_standardx,data_lightx,data_heavyx,stripXPos,data_standardy,data_lighty,data_heavyy,stripYPos,0);

[weight4 summary4 ex4] = findWeightsGEN('normnonneg',data_standardx,data_lightx,data_heavyx,stripXPos,data_standardy,data_lighty,data_heavyy,stripYPos,0);

[weight5 summary5 ex5] = findWeightsGEN('eigen',data_standardx,data_lightx,data_heavyx,stripXPos,data_standardy,data_lighty,data_heavyy,stripYPos,0);

[weight6 summary6 ex6] = findWeightsGEN('original',data_standardx,data_lightx,data_heavyx,stripXPos,data_standardy,data_lighty,data_heavyy,stripYPos,1);

[weight7 summary7 ex7] = findWeightsGEN('originalnonneg',data_standardx,data_lightx,data_heavyx,stripXPos,data_standardy,data_lighty,data_heavyy,stripYPos,1);

[weight8 summary8 ex8] = findWeightsGEN('norm',data_standardx,data_lightx,data_heavyx,stripXPos,data_standardy,data_lighty,data_heavyy,stripYPos,1);

[weight9 summary9 ex9] = findWeightsGEN('normnonneg',data_standardx,data_lightx,data_heavyx,stripXPos,data_standardy,data_lighty,data_heavyy,stripYPos,1);

[weight10 summary10 ex10] = findWeightsGEN('eigen',data_standardx,data_lightx,data_heavyx,stripXPos,data_standardy,data_lighty,data_heavyy,stripYPos,1);

sum1 = [summary1; summary2; summary3; summary4; summary5]

sum2 = [summary6; summary7; summary8; summary9; summary10]

%plotting
figure(1)
visualizeFeet(0,transpose(ex9(1:25)),'m','Forces')
figure(2)
visualizeFeet(0,weight9,'t','Weight')
figure(3)
visualizeFeet(0,transpose(ex9(1:25)).*weight9,'b','Forces*Weight',ex9(26),[ex9(27) ex9(28)])
figure(4)
visualizeFeet(0,transpose(ex9(1:25)).*weight9.*transpose(stripXPos),'b','Forces*Weight*Position',ex9(26),[ex9(27) ex9(28)])