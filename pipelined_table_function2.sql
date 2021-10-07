create or replace type ticker_mimic
as object
(
    ticker VARCHAR2(20),
    pricedate DATE,
    pricetype VARCHAR2(1),
    price NUMBER
);
/

create or replace type list_of_ticker  as table of ticker_mimic;
/

create or replace function fetch_all_ticker()
return list_of_ticker 
PIPELINED
as
begin
    for tc in (select * from tickers) loop
        pipe row (ticker_mimic(tc.ticker, tc.pricedate, tc.pricetype, tc.price));
    end loop;

return;
end;
/

select * from table(fetch_all_ticker());
/

select * from tickers offset 30 rows fetch next 10 rows only;
/