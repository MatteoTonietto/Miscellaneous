% funzione per salvare variabili in un .mat da dentro un ciclo parfor:
%
%   save_parfor(names, var1, var2, ...)
%
%   names = {'nome_del_file','var1','var2',...}

function save_parfor(names,varargin)

    for  i = 1 : length(names)
        
        if i == 1
            string = [char(39),char(names(i)),char(39)];
        else
            string = [string,',',char(39),char(names(i)),char(39)];
            eval([char(names(i)),'=varargin{i-1};'])    
        end
    end
    
    eval(['save(',string,')'])