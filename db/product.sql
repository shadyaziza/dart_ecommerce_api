CREATE TABLE public.product(
    id int8 NOT NULL ,
    name varchar(120) NOT NULL,
    description varchar(255) NOT NULL DEFAULT('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ut ipsum sit amet nulla scelerisque sollicitudin feugiat tincidunt nisl.'),
    price float NOT NULL,
    discount int8 DEFAULT(0),
    CONSTRAINT prod_pk PRIMARY KEY (id)
);

WITH price_list AS (
    SELECT '{75,100,130,150,160,185,200,210,230,250,300,350,400,450,475,500,600,750,850,100,1250}'::FLOAT[] price

),

 discount_list AS(
    SELECT '{10,20,30,40,50}'::INT[] discount
)

INSERT INTO public.product
(id,name,price,discount)
SELECT n,'Product '|| n as name , price[1+mod(n,array_length(price,1))],discount[1+mod(n,array_length(discount,1))]

FROM price_list,discount_list, generate_series(1,10000) as n