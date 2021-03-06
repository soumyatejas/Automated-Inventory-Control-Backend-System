CREATE OR REPLACE PROCEDURE AUTO_ORDER(ITEM_NO_IN INVENTORY_LINE.ITEM_NO%TYPE)
AS
    REF_ORDER_ID NUMBER(12,0);
    REF_FCAST_VAL INTEGER;
    SUP_ID NUMBER(10,0);
    REF_PRICE NUMBER(10,2);
BEGIN
    SELECT MAX(ORDER_ID)
    INTO REF_ORDER_ID
    FROM ORDER_T;
    
    SELECT SUPPLIER_ID
    INTO SUP_ID
    FROM PSA_T A, PSA_LINE_T B
    WHERE A.PSA_ID=B.PSA_ID
    AND ITEM_NO=ITEM_NO_IN
    AND A.END_DATE IS NULL;
    
    SELECT FCAST_VAL
    INTO REF_FCAST_VAL
    FROM ITEM_FCAST_T
    WHERE ITEM_NO=ITEM_NO_IN;
    
    SELECT PRICE 
    INTO REF_PRICE
    FROM PSA_LINE_T
    WHERE ITEM_NO=ITEM_NO_IN;
    
    INSERT INTO ORDER_T
    VALUES(REF_ORDER_ID+1, SUP_ID, 'Created', SYSDATE, NULL);
    
    INSERT INTO ORDER_LINE_T
    VALUES(REF_ORDER_ID+1,ITEM_NO_IN, REF_FCAST_VAL, REF_PRICE*REF_FCAST_VAL, NULL);
    
    COMMIT;
END;