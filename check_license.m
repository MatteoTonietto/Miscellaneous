flag = true;
i = 1;
interval = 300; % intervallo in secondi tra un check e l'altro
while flag
    try
        boxplot(x),
        flag = false;
    catch me
        if strcmp(me.identifier,'MATLAB:license:checkouterror')
            disp(['Waiting... ', num2str(i*interval),' sec'])
            i = i + 1;
            pause(interval)
        else
            disp(me.identifier);
            flag = false;
        end
    end
end