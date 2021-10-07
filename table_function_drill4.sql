CREATE TABLE stocks(
    ticker VARCHAR2(20),
    trade_date DATE,
    open_price NUMBER,
    close_price NUMBER
);
/

BEGIN
    FOR idx IN 1 .. 1000
    LOOP
        insert into stocks values ('STK' || idx, SYSDATE, idx, idx+15);
    END LOOP;

    COMMIT;
END;
/

CREATE TABLE tickers(
    ticker VARCHAR2(20),
    pricedate DATE,
    pricetype VARCHAR2(1),
    price NUMBER
);
/

CREATE or REPLACE PACKAGE stock_manager
    AUTHID DEFINER
IS
    TYPE stocks_rc IS REF CURSOR RETURN stocks%ROWTYPE;
    TYPE tickers_rc IS REF CURSOR RETURN tickers%ROWTYPE;
END stock_manager;
/

CREATE TYPE ticker_ot AUTHID DEFINER IS OBJECT(
    ticker VARCHAR2(20),
    pricedate DATE,
    pricetype VARCHAR2(1),
    price NUMBER
);
/

CREATE TYPE tickers_nt AS TABLE OF ticker_ot;
/

CREATE OR REPLACE FUNCTION doubled (rows_in stock_manager.stocks_rc)
    RETURN tickers_nt AUTHID DEFINER
IS
    TYPE stocks_aat IS TABLE OF stocks%ROWTYPE INDEX BY PLS_INTEGER;
    l_stocks    stocks_aat;
    l_doubled   tickers_nt := tickers_nt();
BEGIN
    LOOP FETCH rows_in BULK COLLECT INTO l_stocks LIMIT 100;
    EXIT WHEN l_stocks.COUNT=0;

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

INSERT INTO tickers
    SELECT * FROM TABLE (doubled (CURSOR (SELECT * FROM stocks)));
/