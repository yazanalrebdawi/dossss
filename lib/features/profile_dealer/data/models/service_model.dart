import 'package:equatable/equatable.dart';

class ServiceModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String location;
  final String status; // "Open Now", "Closed", "Open 24/7"
  final String? closingTime;
  final double rating;
  final String category;
  final String categoryColor;
  final String iconColor;
  final String dealerId;
  final String phoneNumber;
  final String? whatsappNumber;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.status,
    this.closingTime,
    required this.rating,
    required this.category,
    required this.categoryColor,
    required this.iconColor,
    required this.dealerId,
    required this.phoneNumber,
    this.whatsappNumber,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      status: json['status'] ?? 'Closed',
      closingTime: json['closing_time'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      category: json['category'] ?? '',
      categoryColor: json['category_color'] ?? '#4CAF50',
      iconColor: json['icon_color'] ?? '#4CAF50',
      dealerId: json['dealer_id'].toString(),
      phoneNumber: json['phone_number'] ?? '',
      whatsappNumber: json['whatsapp_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'status': status,
      'closing_time': closingTime,
      'rating': rating,
      'category': category,
      'category_color': categoryColor,
      'icon_color': iconColor,
      'dealer_id': dealerId,
      'phone_number': phoneNumber,
      'whatsapp_number': whatsappNumber,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        location,
        status,
        closingTime,
        rating,
        category,
        categoryColor,
        iconColor,
        dealerId,
        phoneNumber,
        whatsappNumber,
      ];
}
