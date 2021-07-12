@AbapCatalog.sqlViewName: 'ZMIOBPICATEG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Category for Sales Order'

@ObjectModel.representativeKey: 'CategoryID'

define view ZMIOBP_I_Category
  as select from zmiobp_categ
  association [0..*] to ZMIOBP_I_CategoryT as _Text on $projection.CategoryID = _Text.CategoryID
{
      @ObjectModel.text.association: '_Text'
  key categoryid as CategoryID,
      _Text
}
