function affine2rigid(input,output)
% input  = trasformazione di ants in .mat
% output = trasformazione di ants in .txt
load(input)

% probabilmente ne mancano alcune
try
    tmp = AffineTransform_double_3_3';
catch
    try
        tmp = AffineTransform_float_3_3';
    catch
        error('Format of the matrix not know')
    end
end

% build affine matrix
RT                        = zeros(4);
RT([1 2 3 5 6 7 9 10 11]) = tmp(1:9);
RT([4 8 12])              = tmp(10:12);
RT(4,4)                   = 1;
RT                        = RT';

RZS = RT(1:3,1:3);
ZS  = chol(RZS'*RZS);

% rotation matrix
R = RZS/ZS;

txt{1  ,1} = {'#Insight Transform File V1.0'};
txt{2  ,1} = {'#Transform 0'};
txt{3  ,1} = {'Transform: MatrixOffsetTransformBase_double_3_3'};
txt{4  ,1} = {['Parameters: ', ...
                num2str(R(1),'%.12f'),' ', ...
                num2str(R(4),'%.12f'),' ', ... 
                num2str(R(7),'%.12f'),' ', ...
                num2str(R(2),'%.12f'),' ', ... 
                num2str(R(5),'%.12f'),' ', ... 
                num2str(R(8),'%.12f'),' ', ... 
                num2str(R(3),'%.12f'),' ', ... 
                num2str(R(6),'%.12f'),' ', ... 
                num2str(R(9),'%.12f'),' ', ...
                num2str(tmp(10),'%.12f'),' ', ...
                num2str(tmp(11),'%.12f'),' ', ...
                num2str(tmp(12),'%.12f')]};
txt{5  ,1} = {['FixedParameters: ', ...
                num2str(fixed(1)','%.12f'),' ', ...
                num2str(fixed(2)','%.12f'),' ', ...
                num2str(fixed(3)','%.12f')]};

fid = fopen(output,'w');
for j = 1 : size(txt,1)
    fprintf(fid,'%s ', char(txt{j,:}) );
    fprintf(fid,'\n');
end
fclose(fid);
  
end

