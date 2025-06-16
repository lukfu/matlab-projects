function alpha = GetSlopeAngle(x, iSlope, iDataSet)

if (iDataSet == 1) % TrainingSet
 if (iSlope == 1)
   alpha = 4 + sin(x/100) + cos(sqrt(2)*x/50);  
 elseif (iSlope == 2) 
   alpha = 4 + 2*cos(sqrt(2)*x/50);  
 elseif (iSlope == 3) 
   alpha = 4 + sin(x/80) + cos(sqrt(5)*x/50);  
 elseif (iSlope == 4) 
   alpha = 5 + sin(x/10) + 2*cos(sqrt(2)*x/50);  
 elseif (iSlope == 5) 
   alpha = 6 + sin(log(abs(x+50)+1)) + cos(sqrt(2)*(x+50)/50);     
 elseif (iSlope == 6) 
   alpha = 4 + sin(sqrt(x+10)/100) + cos(sqrt(2)*(x+50)/50);   
 elseif (iSlope == 7) 
   alpha = 5 + 0.5*sin(x/110) + 2*cos(sqrt(x)/50);   
 elseif (iSlope == 8) 
   alpha = 5 +sin(x/30) + 1*cos(x/80);   
 elseif (iSlope == 9) 
   alpha = 4 + sin(x/60).*cos(x/90) + cos(x/30);    
 elseif (iSlope== 10)
   alpha = 4 + 2*sin(x/50).*cos(x/100).*sin(x/60+5); 
end 
elseif (iDataSet == 2)% ValidationSet
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) + cos(sqrt(3)*x/50);    
 elseif (iSlope == 2) 
   alpha = 5 + 2*cos(x/100).*cos(x/100+10).*cos(x/100+30);    
 elseif (iSlope == 3) 
   alpha = 5 + 2*cos(x/100).*cos(x/90+10).*cos(x/80+30);   
 elseif (iSlope == 4) 
   alpha = 5 + 2*cos(x/100).*cos(x/80+30).*cos(x/60+60);   
 elseif (iSlope == 5) 
   alpha = 5 + 2*cos(x/50).*cos(x/80+30).*cos(x/60+60);   
end 
elseif (iDataSet == 3)% TestSet                           
 if (iSlope == 1) 
   alpha = 6 - sin(x/100) - cos(sqrt(7)*x/50);   
 elseif (iSlope == 2)
   alpha = 4 + (x/1000) + sin(x/50).*cos(x/100)+cos(x/80); 
 elseif (iSlope == 3)
   alpha = 4 + (x/1000) + sin(x/60).*cos(x/60+60)+cos(x/60); 
 elseif (iSlope == 4)
   alpha = 5 + (x/2000) + sin(x/80).*cos(x/80)+cos(x/80)+cos(x/70+30); 
 elseif (iSlope == 5)
   alpha = 4 + (x/1000) + sin(x/70) + cos(x/100); 
 end
end
