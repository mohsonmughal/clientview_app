class KdsSettings {
  String? tipActive;
  String? tipCalculation;
  String? enableSmartTipping;
  String? minimumOrderAmountThreshold;
  String? minimumNumberOfCustomersThreshold;
  String? flatTippingThreshold;
  List<CustomTipRow>? customTipRow;
  String? autoTypeTippingThreshold;
  String? customTypeTippingThreshold;

  KdsSettings({
    this.tipActive,
    this.tipCalculation,
    this.enableSmartTipping,
    this.minimumOrderAmountThreshold,
    this.minimumNumberOfCustomersThreshold,
    this.flatTippingThreshold,
    this.customTipRow,
    this.autoTypeTippingThreshold,
    this.customTypeTippingThreshold,
  });

  factory KdsSettings.fromMap(Map<String, dynamic> json) => KdsSettings(
    tipActive: json["tip_active"] ?? '',
    tipCalculation: json["tip_calculation"] ?? '',
    enableSmartTipping: json["enable_smart_tipping"] ?? '',
    minimumOrderAmountThreshold:
    json["minimum_order_amount_threshold"] ?? '',
    minimumNumberOfCustomersThreshold:
    json["minimum_number_of_customers_threshold"] ?? '',
    flatTippingThreshold: json["flat_tipping_threshold"] ?? '',
    customTipRow: json["custom_tip_row"] == null
        ? []
        : List<CustomTipRow>.from(
        json["custom_tip_row"]!.map((x) => CustomTipRow.fromMap(x))),
    autoTypeTippingThreshold: json["auto_type_tipping_threshold"] ?? '',
    customTypeTippingThreshold: json["custom_type_tipping_threshold"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "tip_active": tipActive,
    "tip_calculation": tipCalculation,
    "enable_smart_tipping": enableSmartTipping,
    "minimum_order_amount_threshold": minimumOrderAmountThreshold,
    "minimum_number_of_customers_threshold":
    minimumNumberOfCustomersThreshold,
    "flat_tipping_threshold": flatTippingThreshold,
    "custom_tip_row": customTipRow == null
        ? []
        : List<dynamic>.from(customTipRow!.map((x) => x.toMap())),
    "auto_type_tipping_threshold": autoTypeTippingThreshold,
    "custom_type_tipping_threshold": customTypeTippingThreshold,
  };
}

class CustomTipRow {
  String? active;
  String? percentageAmount;
  String? flatAmount;
  String? tipLabel;

  CustomTipRow({
    this.active,
    this.percentageAmount,
    this.flatAmount,
    this.tipLabel,
  });

  factory CustomTipRow.fromMap(Map<String, dynamic> json) => CustomTipRow(
    active: json["active"] ?? '',
    percentageAmount: json["percentage_amount"] ?? '',
    flatAmount: json["flat_amount"] ?? '',
    tipLabel: json["tip_label"] ?? '',
  );

  Map<String, dynamic> toMap() => {
    "active": active,
    "percentage_amount": percentageAmount,
    "flat_amount": flatAmount,
    "tip_label": tipLabel,
  };
}