
  
    

    create or replace table `sportmetrics-480616`.`dbt_lkalbusch`.`my_second_dbt_model`
      
    
    

    
    OPTIONS()
    as (
      -- Use the `ref` function to select from other models

select *
from `sportmetrics-480616`.`dbt_lkalbusch`.`my_first_dbt_model`
where id = 1
    );
  