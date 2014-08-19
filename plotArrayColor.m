function [] = visualizeFeet(array,toplot)
if array
    x = arrayXPos;
    y = arrayYPos;
else
    x = stripXPos;
    y = stripYPos;
end

color = horzcat(zeros(size(toplot)),toplot,zeros(size(toplot)));

scatter(x,y,400,colors,'fill')

end