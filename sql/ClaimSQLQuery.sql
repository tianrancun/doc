select top 10 * from claims.claim_item;

select top 10  item_qty,on_hand_qty,open_claim_qty from claims.claim_catalog

select top 10 * from claims.inventory_swap;
--closebox
select * from claims.Claim c where c.club_Nbr = 4242 and c.state = 'open' -- c.claimId = ?1 and
--init claims 
--find all
select * from claims_sequence;

--http://localhost:8080/claims/4242/activeMkdns
select * from claims.markdown_item m where m.club_nbr = 4242 and m.state ='open';
--http://localhost:8080/claims/4242/boxesInfo
--RCTR
select * from claims.Claim  c where c.club_Nbr = 4242 and c.claim_reason_code in ('DEFC','RCLL') 
and c.claim_disposition_type_code in ('SHIP') and c.claim_type_code in ('RCTR') and c.state not in ('SHIPPED','DELETED');
--SUPP
select * from claims.Claim  c where c.club_Nbr = 4242 and c.claim_reason_code in ('DEFC','RCLL') 
and c.claim_disposition_type_code in ('SHIP') and c.claim_type_code in ('SUPP') and c.state not in ('SHIPPED','DELETED');
--JRCTR
select * from claims.Claim  c where c.club_Nbr = 4242 and c.claim_reason_code in ('RCLL') 
and c.claim_disposition_type_code in ('SHIP') and c.claim_type_code in ('JRCTR') and c.state not in ('SHIPPED','DELETED');
------------
select distinct state from claims.claim;

--http://localhost:8080/claims/4242/claimsInfoV2
select * from claims.claim_catalog c;
---RCTR
select count(1) from claims.claim_catalog c where c.club_nbr = 4808 and ((c.item_qty - c.open_claim_qty) > 0 )
and c.claim_reason_code in('DEFC') and c.claim_disposition_type_code in ('SHIP') and c.claim_type_code in ('RCTR') and c.is_active = 1
--SUPP
select count(1) from claims.claim_catalog c where c.club_nbr = 4808 and ((c.item_qty - c.open_claim_qty) > 0 )
and c.claim_reason_code in('DEFC') and c.claim_disposition_type_code in ('SHIP') and c.claim_type_code in ('SUPP') and c.is_active = 1
--MKDN
select count(1) from claims.claim_catalog c where c.club_nbr = 4808 and ((c.item_qty - c.open_claim_qty) > 0 )
and c.claim_reason_code in('DEFC') and c.claim_disposition_type_code in ('DISP') and c.claim_type_code in ('MKDN') and c.is_active = 1
--RCLL
select count(1) from claims.claim_catalog c where c.club_nbr = 4808 and ((c.item_qty - c.open_claim_qty) > 0 ) and
c.claim_reason_code = 'RCLL' and c.claim_type_code!= 'MKDN' and c.claim_disposition_type_code = 'SHIP' 
and c.recall_start_date <= getdate() and c.recall_end_date > getdate() and c.is_active = 1;
--HOLD
select count(1) from claims.claim_catalog c where c.club_nbr = 4808 and ((c.item_qty - c.open_claim_qty) > 0 )
and c.claim_reason_code in('DEFC') and c.claim_disposition_type_code in ('HOLD') and c.claim_type_code in ('SUPP') and c.is_active = 1
--DISP
select count(1) from claims.claim_catalog c where c.club_nbr = 4808 and ((c.item_qty - c.open_claim_qty) > 0 )
and c.claim_reason_code in('DEFC') and c.claim_disposition_type_code in ('DISP') and c.claim_type_code in ('SUPP') and c.is_active = 1

--https://sandbox-cluboperations-claims.azurewebsites.net/claims/4969/disposalItems
select * from claims.claim_catalog c where c.club_nbr = 4242 and ((c.item_qty - c.open_claim_qty) > 0 ) and 
c.claim_reason_code in('DEFC') and c.claim_disposition_type_code in ('DISP') and c.claim_type_code in ('SUPP') and c.is_active = 1

--http://localhost:8080/claims/4242/getFinPendingClaims
select * from claims.claim_backfeed c where c.club_nbr = 4242 and c.to_be_sent = 0
--update claims.claim_backfeed set to_be_sent =1 where claim_id =47;
--select * from claims.claim_backfeed where claim_id = 47

select claim.*
  from
        claims.claim  
    inner join
        claims.claim_item  
            on claim.claim_id=claim_item.claim_id 
    where
       claim.claim_id =47 
        and claim.club_nbr=4242
        and claim.state<>'DELETED' 
        and claim_item.is_backfeed_fail=0 
        and claim_item.is_deleted_on_corr=0

select * from claims.claim_correction c where c.club_nbr =4242 and c.correction_state in ('to_be_corrected')

select * from claims.claim_item where claim_id = 831
select * from claims.claim where claim_id = 831

--itemInfoV2
select * from claim_catalog c where c.item_nbr = 785786357 and c.club_nbr = 4242 and c.claim_reason_code ='RCLL';

--
select m from MarkdownItem m where m.clubNo = :clubNo and m.state =:state


select * from dbo.markdown_Item;
select * from claims.markdown_Item;
select
       *
    from
        claims.markdown_item markdownit0_ 
    where
        markdownit0_.club_nbr=? 
        and markdownit0_.state=?
