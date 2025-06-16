function visibility = GetVisibility(cityLocation)
   cityLocationLength = size(cityLocation,1);
   visibility = zeros(cityLocationLength,cityLocationLength);
   for i = 1:cityLocationLength
       for j = 1:cityLocationLength
           if i ~= j
           euclideanDistance = norm(cityLocation(j,:) - cityLocation(i,:));
           visibility(i,j) = 1/euclideanDistance;
           end
       end
   end
end