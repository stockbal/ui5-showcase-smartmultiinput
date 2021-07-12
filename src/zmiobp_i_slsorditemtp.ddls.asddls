@AbapCatalog.sqlViewName: 'ZMIOBPISLOITP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Item'

@Search.searchable:       true

@ObjectModel: {
  semanticKey:  [ 'SalesOrderItem' ],
  writeActivePersistence: 'zmiobp_sordit',
  createEnabled: true,
  deleteEnabled: true,
  updateEnabled: true,
  writeDraftPersistence: 'zmiobp_sorditd'
}

define view ZMIOBP_I_SlsOrdItemTP
  as select from zmiobp_sordit

  /* Compositional associations    */
  association [1..1] to ZMIOBP_I_SalesOrderTP          as _SalesOrder          on $projection.SalesOrderUUID = _SalesOrder.SalesOrderUUID
  association [0..*] to ZMIOBP_I_SlsOrdItmCurrAssgmtTP as _SalesOrdItmCurrency on $projection.SalesOrderItemUUID = _SalesOrdItmCurrency.SalesOrderItemUUID

  /* Cross BO associations         */
  association [0..1] to SEPM_I_Product_E               as _Product             on $projection.Product = _Product.Product

  /* Associations for value help   */
  association [0..1] to SEPM_I_Currency                as _Currency            on $projection.CurrencyCode = _Currency.Currency
{

      @ObjectModel.readOnly: true
  key salesorderitemuuid as SalesOrderItemUUID,

      @ObjectModel.readOnly: true
      salesorderuuid     as SalesOrderUUID,

      @Search.defaultSearchElement: true
      @ObjectModel.readOnly: true
      salesorderitem     as SalesOrderItem,

      @ObjectModel.foreignKey.association: '_Product'
      @ObjectModel.mandatory: true
      product            as Product,

      @ObjectModel.foreignKey.association: '_Currency'
      @Semantics.currencyCode: true
      @ObjectModel.readOnly: true
      currencycode       as CurrencyCode,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      @ObjectModel.readOnly: true
      grossamount        as GrossAmount,

      quantity           as Quantity,


      /*  Exposed associations  */
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _SalesOrder,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _SalesOrdItmCurrency,
      _Product,
      _Currency
}
