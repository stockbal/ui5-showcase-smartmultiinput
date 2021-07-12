@AbapCatalog.sqlViewName: 'ZMIOBPISOTP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order (TX)'

@Search.searchable: true

@ObjectModel: {
    transactionalProcessingEnabled: true,

    compositionRoot: true, -- on root node only

    createEnabled:  true,
    deleteEnabled:  true,
    updateEnabled:  true,

    writeActivePersistence: 'zmiobp_sord',

    draftEnabled: true,
    writeDraftPersistence: 'zmiobp_sord_d',
    entityChangeStateId: 'ChangedAt',

    semanticKey: ['SalesOrder']
}



define view ZMIOBP_I_SalesOrderTP

  as select from zmiobp_sord as SalesOrder -- the sales order table is the data source for this view

  association [0..1] to SEPM_I_BusinessPartner         as _BusinessPartner   on $projection.BusinessPartner = _BusinessPartner.BusinessPartner

  association [0..1] to SEPM_I_Currency                as _Currency          on $projection.CurrencyCode = _Currency.Currency

  association [0..1] to SEPM_I_SalesOrderBillingStatus as _BillingStatus     on $projection.BillingStatus = _BillingStatus.SalesOrderBillingStatus

  association [0..1] to Sepm_I_SalesOrdOverallStatus   as _OverallStatus     on $projection.OverallStatus = _OverallStatus.SalesOrderOverallStatus

  association [0..*] to ZMIOBP_I_SlsOrdCategAssgmtTP   as _SlsOrdCategAssgmt on $projection.SalesOrderUUID = _SlsOrdCategAssgmt.SalesOrderUUID

  association [0..*] to ZMIOBP_I_SlsOrdItemTP          as _SalesOrderItem    on $projection.SalesOrderUUID = _SalesOrderItem.SalesOrderUUID

{
      -- UUID-based key is required to enable draft capabilities
      @ObjectModel.readOnly: true
  key SalesOrder.salesorderuuid  as SalesOrderUUID,

      @Search.defaultSearchElement: true
      @ObjectModel.readOnly: true
      SalesOrder.salesorder      as SalesOrder,

      @ObjectModel.foreignKey.association: '_BusinessPartner'
      SalesOrder.businesspartner as BusinessPartner,

      @ObjectModel.foreignKey.association: '_Currency'
      @Semantics.currencyCode: true
      SalesOrder.currencycode    as CurrencyCode,

      @Semantics.amount.currencyCode: 'CurrencyCode'

      SalesOrder.grossamount     as GrossAmount,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      SalesOrder.netamount       as NetAmount,

      @ObjectModel.foreignKey.association: '_BillingStatus'
      SalesOrder.billingstatus   as BillingStatus,

      @ObjectModel.foreignKey.association: '_OverallStatus'
      SalesOrder.overallstatus   as OverallStatus,

      @Semantics.systemDateTime.lastChangedAt: true
      SalesOrder.changedat       as ChangedAt,

      @Semantics.systemDateTime.createdAt: true
      SalesOrder.createdat       as CreatedAt,
      @Semantics.user.createdBy: true
      SalesOrder.createdby       as CreatedBy,
      @Semantics.user.lastChangedBy: true
      SalesOrder.changedby       as ChangedBy,

      /* Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _SlsOrdCategAssgmt,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _SalesOrderItem,
      _BusinessPartner,
      _Currency,
      _BillingStatus,
      _OverallStatus
}
