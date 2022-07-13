import 'package:flutter/material.dart';
import 'package:unsplash_images/data/entity/photo.dart';

class PhotoListWidget extends StatelessWidget {
  const PhotoListWidget({
    Key? key,
    required this.scrollController,
    required this.photoList,
    this.likePhoto,
    this.unlikePhoto,
    this.downloadPhoto,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<Photo> photoList;
  final Future<void> Function(String photoId, int index)? likePhoto;
  final Future<void> Function(String photoId, int index)? unlikePhoto;
  final Future<void> Function(String downloadUrl)? downloadPhoto;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        controller: scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: photoList.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _photoItemHeader(index),
              ),
              const SizedBox(height: 12),
              _photoItem(index),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (likePhoto != null && unlikePhoto != null)
                      _favouriteBtn(index),
                    if (downloadPhoto != null) _downloadBtn(index),
                  ],
                ),
              ),
            ],
          );
        }),
        separatorBuilder: (context, index) {
          return const SizedBox(height: 50);
        },
      ),
    );
  }

  Widget _photoItemHeader(int index) {
    final photo = photoList[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 16,
          backgroundImage: NetworkImage(
            photo.user.profileImage.medium,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          photo.user.username,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _photoItem(int index) {
    return Image.network(
      photoList[index].urls.regular,
      height: 250,
      fit: BoxFit.cover,
      width: double.infinity,
      gaplessPlayback: true,
    );
  }

  Widget _favouriteBtn(int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () async {
        photoList[index].likedByUser
            ? await unlikePhoto!(photoList[index].id, index)
            : await likePhoto!(photoList[index].id, index);
      },
      child: Container(
        width: 39,
        height: 32,
        decoration: BoxDecoration(
          color: photoList[index].likedByUser ? Colors.red : null,
          border: Border.all(
            color: photoList[index].likedByUser
                ? Colors.red
                : const Color.fromRGBO(209, 209, 209, 1),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          Icons.favorite,
          color: photoList[index].likedByUser
              ? Colors.white
              : const Color.fromRGBO(118, 118, 118, 1),
        ),
      ),
    );
  }

  Widget _downloadBtn(int index) {
    return InkWell(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(4),
        bottomLeft: Radius.circular(4),
      ),
      onTap: () async {
        await downloadPhoto!(photoList[index].urls.regular);
      },
      child: Container(
        width: 86,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromRGBO(209, 209, 209, 1),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4),
          ),
        ),
        child: const Center(
          child: Text(
            'Download',
            style: TextStyle(
              color: Color.fromRGBO(118, 118, 118, 1),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
