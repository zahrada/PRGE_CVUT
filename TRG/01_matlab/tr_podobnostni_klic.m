function [x,v,vmax,mnul,sigmax,tx,ty,q,om] = tr_podobnostni_klic(matrix)
    % 1) naplnime vektor mereni
    i = 0;
    while (i~=size(matrix,1))
        i = i+1;
        j = 2*i - 1;
        l(j,1)   = matrix(i,1);
        l(j+1,1) = matrix(i,2);
    end
    % 2) naplnime matici planu
    i = 0;
    while (i~=size(matrix,1))
        i = i+1;
        j = 2*i - 1;
        % radek pro X
        A(j,1) = 1;
        A(j,2) = 0;
        A(j,3) = matrix(i,3);
        A(j,4) = -matrix(i,4);
        % radek pro Y
        A(j+1,1) = 0;
        A(j+1,2) = 1;
        A(j+1,3) = matrix(i,4);
        A(j+1,4) = matrix(i,3);
    end 
    % 3) aplikujeme MNC
    x      = inv(A'*A)*A'*l;
    v      = A*x - l;
    vmax   = max(abs(v));
    mnul   = sqrt(v'*v/(size(l,1)-size(x,1)));
    covx   = (mnul^2)*inv(A'*A);
    sigmax = diag(sqrt(covx));
    covl   = A*covx*A';
    sigmal = diag(sqrt(covl));
    % 4) podobnostni: tx,ty,a,b
    tx = x(1); ty = x(2);
    a = x(3); b = x(4);    
    q  = sqrt (a*a + b*b);
    om = atan2(b,a)*200/pi;
end