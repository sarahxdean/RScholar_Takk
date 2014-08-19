%first, import july11sxdata and july11sydata

findWeightsJuly23Parse_array

[weight1 summary1 ex1] = findWeightsGEN('original',data_standardx,data_lightx,data_heavyx,arrayXPos,data_standardy,data_lighty,data_heavyy,arrayYPos,0);

[weight2 summary2 ex2] = findWeightsGEN('originalnonneg',data_standardx,data_lightx,data_heavyx,arrayXPos,data_standardy,data_lighty,data_heavyy,arrayYPos,0);

[weight3 summary3 ex3] = findWeightsGEN('norm',data_standardx,data_lightx,data_heavyx,arrayXPos,data_standardy,data_lighty,data_heavyy,arrayYPos,0);

[weight4 summary4 ex4] = findWeightsGEN('normnonneg',data_standardx,data_lightx,data_heavyx,arrayXPos,data_standardy,data_lighty,data_heavyy,arrayYPos,0);

[weight5 summary5 ex5] = findWeightsGEN('eigen',data_standardx,data_lightx,data_heavyx,arrayXPos,data_standardy,data_lighty,data_heavyy,arrayYPos,0);

[weight6 summary6 ex6] = findWeightsGEN('original',data_standardx,data_lightx,data_heavyx,arrayXPos,data_standardy,data_lighty,data_heavyy,arrayYPos,1);

[weight7 summary7 ex7] = findWeightsGEN('originalnonneg',data_standardx,data_lightx,data_heavyx,arrayXPos,data_standardy,data_lighty,data_heavyy,arrayYPos,1);

[weight8 summary8 ex8] = findWeightsGEN('norm',data_standardx,data_lightx,data_heavyx,arrayXPos,data_standardy,data_lighty,data_heavyy,arrayYPos,1);

[weight9 summary9 ex9] = findWeightsGEN('normnonneg',data_standardx,data_lightx,data_heavyx,arrayXPos,data_standardy,data_lighty,data_heavyy,arrayYPos,1);

[weight10 summary10 ex10] = findWeightsGEN('eigen',data_standardx,data_lightx,data_heavyx,arrayXPos,data_standardy,data_lighty,data_heavyy,arrayYPos,1);

sum1 = [summary1; summary2; summary3; summary4; summary5]

sum2 = [summary6; summary7; summary8; summary9; summary10]
