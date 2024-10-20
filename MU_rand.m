function [MU]=MU_rand(MU_set,iter_gauss,mean,std_dev,interval)
if iter_gauss==1
    MU_1=0;
    MU_2=0;
else
    MU_1=MU_set(iter_gauss,1);
    MU_2=MU_set(iter_gauss,2);

    flag=true;

    while flag
   
        % Generate a normally distributed random number
        random_1 = normrnd(mean, std_dev);
        if rand()>0.5
        random_1=random_1*-1;
    
        end
 
        % Generate a normally distributed random number
        random_2 = normrnd(mean, std_dev); 
        if rand()>0.5     
            random_2=random_2*-1;
        end

        MU_1=MU_1+random_1();  
        MU_2=MU_2+random_2();
        flag=false;
        for i=1:iter_gauss
            if distance(MU_1,MU_2,MU_set(i,1),MU_set(i,2))<interval 
                flag=true;
            end
        end
    end
end

MU=[MU_1,MU_2];