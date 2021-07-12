@AbapCatalog.sqlViewName: 'ZMIOBPCSOTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order - Consumption (TX)'

@Search.searchable: true

@Metadata.allowExtensions: true

@ObjectModel: {
   -- Annotations for transactional processing
   semanticKey: ['SalesOrder'],
   compositionRoot: true,
   transactionalProcessingDelegated: true,
   createEnabled: true,
   deleteEnabled: true,
   updateEnabled: true,

   -- Additional annotation for draft enablement
   draftEnabled: true
}

define view ZMIOBP_C_SalesOrderTP
  as select from ZMIOBP_I_SalesOrderTP

  association [0..*] to ZMIOBP_C_SlsOrdCategAssgmtTP as _SlsOrdCategAssgmt on $projection.SalesOrderUUID = _SlsOrdCategAssgmt.SalesOrderUUID
  association [0..*] to ZMIOBP_C_SlsOrdItemTP        as _SalesOrderItem    on $projection.SalesOrderUUID = _SalesOrderItem.SalesOrderUUID
{
  key SalesOrderUUID,

      @Search.defaultSearchElement: true
      SalesOrder,
      BusinessPartner,
      CurrencyCode,
      GrossAmount,
      NetAmount,
      BillingStatus,
      OverallStatus,
      ChangedAt,
      CreatedAt,
      CreatedBy,
      ChangedBy,

      /* Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _SalesOrderItem,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _SlsOrdCategAssgmt,
      _BillingStatus,
      _BusinessPartner,
      _Currency,
      _OverallStatus
}
