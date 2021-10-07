CREATE OR REPLACE TYPE strings_t IS TABLE OF VARCHAR2 (200);
/

CREATE OR REPLACE FUNCTION strings
    RETURN strings_t PIPELINED
    AUTHID DEFINER
IS
BEGIN
    PIPE ROW ('abs');
    RETURN;
END;
/

select COLUMN_VALUE my_string from table (strings_t());
/

select COLUMN_VALUE my_string from strings_t();
/


CREATE TABLE stocks (
    ticker VARCHAR2(20),
    trade_date DATE,
    open_price NUMBER,
    close_price NUMBER
);
/


INSERT INTO stocks SELECT 'STK' || LEVEL, SYSDATE, LEVEL, LEVEL + 15 FROM dual CONNECT BY LEVEL <= 200000;
/


CREATE OR REPLACE FUNCTION doubled_nopl (rows_in stock_manager.stocks_rc)
    RETURN tickers_nt AUTHID DEFINER
IS
    TYPE stocks_aat IS TABLE OF stocks%ROWTYPE INDEX BY PLS_INTEGER;
    l_stocks    stocks_aat;
    l_doubled   tickers_nt := tickers_nt();
BEGIN
    LOOP 
        FETCH rows_in BULK COLLECT INTO l_stocks LIMIT 100;
        EXIT WHEN l_stocks.COUNT = 0;

        FOR l_row IN 1 .. l_stocks.COUNT
        LOOP
            l_doubled.EXTEND;
            l_doubled (l_doubled.LAST) := ticker_ot(l_stocks (l_row).ticker,
                                            l_stocks (l_row).trade_date,
                                            'O',
                                            l_stocks (l_row).open_price);

            l_doubled (l_doubled.LAST) := ticker_ot(l_stocks (l_row).ticker,
                                            l_stocks (l_row).trade_date,
                                            'C',
                                            l_stocks (l_row).open_price);
        END LOOP;
    END LOOP;

    CLOSE rows_in;
    RETURN l_doubled;
END;
/

CREATE OR REPLACE FUNCTION doubled_pl (rows_in stock_manager.stocks_rc)
    RETURN tickers_nt PIPELINED AUTHID DEFINER
IS
    TYPE stocks_aat IS TABLE OF stocks%ROWTYPE INDEX BY PLS_INTEGER;
    l_stocks    stocks_aat;
    l_doubled   tickers_nt := tickers_nt();
BEGIN
    LOOP 
        FETCH rows_in BULK COLLECT INTO l_stocks LIMIT 100;
        EXIT WHEN l_stocks.COUNT = 0;

        FOR l_row IN 1 .. l_stocks.COUNT
        LOOP
            PIPE ROW (ticker_ot(l_stocks (l_row).ticker,
                                            l_stocks (l_row).trade_date,
                                            'O',
                                            l_stocks (l_row).open_price));

            PIPE ROW  (ticker_ot(l_stocks (l_row).ticker,
                                            l_stocks (l_row).trade_date,
                                            'C',
                                            l_stocks (l_row).open_price));
        END LOOP;
    END LOOP;

    CLOSE rows_in;
    RETURN;
END;
/

SELECT COUNT(*) FROM tickers;
/

INSERT INTO tickers select * FROM (doubled_pl(CURSOR (SELECT * FROM stocks)));
/

commit;
/

select * from tickers;
/