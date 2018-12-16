function [dX dY] = interpolace(X,Y)

korekce;

rr1 = 100000;
rr2 = 100000;
rr3 = 100000;
rr4 = 100000;
for i = 1 : rows(korekce)
  Yi = korekce(i,1);
  Xi = korekce(i,2);
  dYi = korekce(i,3);
  dXi = korekce(i,4);
  deltaX = Xi - X;
  deltaY = Yi - Y;
  r = sqrt(deltaX^2 + deltaY^2);
  if ((deltaY < 0) && (deltaX > 0))
    if (rr1 > r)
      rr1 = r;
      X1 = Xi;
      Y1 = Yi;
      dX1 = dXi;
      dY1 = dYi;
    end
  end
  if ((deltaY > 0) && (deltaX > 0))
    if (rr2 > r)
      rr2 = r;
      X2 = Xi;
      Y2 = Yi;
      dX2 = dXi;
      dY2 = dYi;
    end
  end
  if ((deltaY < 0) && (deltaX < 0))
    if (rr3 > r)
      rr3 = r;
      X3 = Xi;
      Y3 = Yi;
      dX3 = dXi;
      dY3 = dYi;
    end
  end
  if ((deltaY > 0) && (deltaX < 0))
    if (rr4 > r)
      rr4 = r;
      X4 = Xi;
      Y4 = Yi;
      dX4 = dXi;
      dY4 = dYi;
    end
  end
end



if (rr1 < rr2 && rr1 < rr3 && rr1 < rr4)
  X5 = X1 + 2000;
  Y5 = Y1 - 2000;
  X6 = X1 + 2000;
  Y6 = Y1;
  X7 = X1 + 2000;
  Y7 = Y1 + 2000;
  X8 = X1;
  Y8 = Y1 - 2000;
  X9 = X1 - 2000;
  Y9 = Y1 - 2000;
  for i = 1 : rows(korekce)
    Yi = korekce(i,1);
    Xi = korekce(i,2);
    dYi = korekce(i,3);
    dXi = korekce(i,4);
    if (Xi == X5 && Yi == Y5)
      dX5 = dXi;
      dY5 = dXi;
    end
    if (Xi == X6 && Yi == Y6)
      dX6 = dXi;
      dY6 = dYi;
    end
    if (Xi == X7 && Yi == Y7)
      dX7 = dXi;
      dY7 = dYi;
    end
    if (Xi == X8 && Yi == Y8)
      dX8 = dXi;
      dY8 = dYi;
    end
    if (Xi == X9 && Yi == Y9)
      dX9 = dXi;
      dY9 = dYi;
    end
  end
end

if (rr2 < rr1 && rr2 < rr3 && rr2 < rr4)
  X5 = X2 + 2000;
  Y5 = Y2 + 2000;
  X6 = X2 + 2000;
  Y6 = Y2;
  X7 = X2 + 2000;
  Y7 = Y2 - 2000;
  X8 = X2;
  Y8 = Y2 + 2000;
  X9 = X2 - 2000;
  Y9 = Y2 + 2000;
  for i = 1 : rows(korekce)
    Yi = korekce(i,1);
    Xi = korekce(i,2);
    dYi = korekce(i,3);
    dXi = korekce(i,4);
    if (Xi == X5 && Yi == Y5)
      dX5 = dXi;
      dY5 = dXi;
    end
    if (Xi == X6 && Yi == Y6)
      dX6 = dXi;
      dY6 = dYi;
    end
    if (Xi == X7 && Yi == Y7)
      dX7 = dXi;
      dY7 = dYi;
    end
    if (Xi == X8 && Yi == Y8)
      dX8 = dXi;
      dY8 = dYi;
    end
    if (Xi == X9 && Yi == Y9)
      dX9 = dXi;
      dY9 = dYi;
    end
  end
end

if (rr3 < rr1 && rr3 < rr2 && rr3 < rr4)
  X5 = X3 - 2000;
  Y5 = Y3 - 2000;
  X6 = X3;
  Y6 = Y3 - 2000;
  X7 = X3 + 2000;
  Y7 = Y3 - 2000;
  X8 = X3 - 2000;
  Y8 = Y3;
  X9 = X3 - 2000;
  Y9 = Y3 + 2000;
  for i = 1 : rows(korekce)
    Yi = korekce(i,1);
    Xi = korekce(i,2);
    dYi = korekce(i,3);
    dXi = korekce(i,4);
    if (Xi == X5 && Yi == Y5)
      dX5 = dXi;
      dY5 = dXi;
    end
    if (Xi == X6 && Yi == Y6)
      dX6 = dXi;
      dY6 = dYi;
    end
    if (Xi == X7 && Yi == Y7)
      dX7 = dXi;
      dY7 = dYi;
    end
    if (Xi == X8 && Yi == Y8)
      dX8 = dXi;
      dY8 = dYi;
    end
    if (Xi == X9 && Yi == Y9)
      dX9 = dXi;
      dY9 = dYi;
    end
  end
end

if (rr4 < rr1 && rr4 < rr2 && rr4 < rr3)
  X5 = X4 - 2000;
  Y5 = Y4 + 2000;
  X6 = X4;
  Y6 = Y4 + 2000;
  X7 = X4 + 2000;
  Y7 = Y4 + 2000;
  X8 = X4 - 2000;
  Y8 = Y4;
  X9 = X4 - 2000;
  Y9 = Y4 - 2000;
  for i = 1 : rows(korekce)
    Yi = korekce(i,1);
    Xi = korekce(i,2);
    dYi = korekce(i,3);
    dXi = korekce(i,4);
    if (Xi == X5 && Yi == Y5)
      dX5 = dXi;
      dY5 = dXi;
    end
    if (Xi == X6 && Yi == Y6)
      dX6 = dXi;
      dY6 = dYi;
    end
    if (Xi == X7 && Yi == Y7)
      dX7 = dXi;
      dY7 = dYi;
    end
    if (Xi == X8 && Yi == Y8)
      dX8 = dXi;
      dY8 = dYi;
    end
    if (Xi == X9 && Yi == Y9)
      dX9 = dXi;
      dY9 = dYi;
    end
  end
end

body = [	X1	Y1	dX1	dY1
		X3	Y3	dX3	dY3
		X5	Y5	dX5	dY5
		X2	Y2	dX2	dY2
		X4	Y4	dX4	dY4
		X6	Y6	dX6	dY6
		X7	Y7	dX7	dY7
		X8	Y8	dX8	dY8
		X9	Y9	dX9	dY9];

vec_X1 = [X1	Y1	dX1	dY1];
vec_X3 = [X3	Y3	dX3	dY3];
vec_X5 = [X5	Y5	dX5	dY5];
for i = 4 : 9
  if (body(i,1) == X1)
    if (body(i,2) < vec_X1(1,2))
      vec_X1 = [	body(i,:)
			vec_X1];
    elseif  (body(i,2) > vec_X1(rows(vec_X1),2))
      vec_X1 = [	vec_X1
			body(i,:)];
    else
      vec_X1 = [	vec_X1(1,:)
			body(i,:)
			vec_X1(2,:)];
    end
  end
  if (body(i,1) == X3)
    if (body(i,2) < vec_X3(1,2))
      vec_X3 = [	body(i,:)
			vec_X3];
    elseif  (body(i,2) > vec_X3(rows(vec_X3),2))
      vec_X3 = [	vec_X3
			body(i,:)];
    else
      vec_X3 = [	vec_X3(1,:)
			body(i,:)
			vec_X3(2,:)];
    end
  end
  if (body(i,1) == X5)
    if (body(i,2) < vec_X5(1,2))
      vec_X5 = [	body(i,:)
			vec_X5];
    elseif  (body(i,2) > vec_X5(rows(vec_X5),2))
      vec_X5 = [	vec_X5
			body(i,:)];
    else
      vec_X5 = [	vec_X5(1,:)
			body(i,:)
			vec_X15(2,:)];
    end
  end
end


dX_X1 = polyfit(vec_X1(:,2),vec_X1(:,3),2);
dY_X1 = polyfit(vec_X1(:,2),vec_X1(:,4),2);
inter_y = [vec_X1(1,1), polyval(dX_X1,Y), polyval(dY_X1,Y)];

dX_X3 = polyfit(vec_X3(:,2),vec_X3(:,3),2);
dY_X3 = polyfit(vec_X3(:,2),vec_X3(:,4),2);
inter_y = [	inter_y
		vec_X3(1,1), polyval(dX_X3,Y), polyval(dY_X3,Y)];

dX_X5 = polyfit(vec_X5(:,2),vec_X5(:,3),2);
dY_X5 = polyfit(vec_X5(:,2),vec_X5(:,4),2);

inter_y = [	inter_y
		vec_X5(1,1), polyval(dX_X5,Y), polyval(dY_X5,Y)];

dX_Y = polyfit(inter_y(:,1),inter_y(:,2),2);
dY_Y = polyfit(inter_y(:,1),inter_y(:,3),2);

dX = polyval(dX_Y,X);
dY = polyval(dY_Y,X);