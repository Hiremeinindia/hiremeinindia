import 'dart:typed_data';

class Attachment {
  final String name;
  final List<String> imageUrls;
  final AttachmentLocation attachmentLocation;
  Uint8List? rawData;
  Attachment(
      {required this.name,
      required this.imageUrls,
      required this.attachmentLocation,
      this.rawData});

  toJson() => {
        'name': name,
        'url': imageUrls,
      };
  factory Attachment.fromJson(json) => Attachment(
        name: json['name'],
        imageUrls: json['imageUrl'],
        attachmentLocation: AttachmentLocation.cloud,
      );
}

enum AttachmentLocation { local, cloud }
