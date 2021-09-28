# Todo

version: 1.0.0+1

- Demo
  - [x] db index (save Initiated in 5080-7000 ms)
  - [x] Bottom navigation show/hide
  - [x] Search features
  - [x] SliverPersistentHeaderDelegate
  - [x] Languages -> switch
  - [x] Theme -> switch light/dark
  - [x] SliverReorderableList with drag handler
  - [x] refresh -> CupertinoSliverRefreshControl
  - [ ] custom font size change
  - [ ] Popup
  - [x] Swipe to delete from
    - [ ] left
    - [x] right
  - [x] Swipe for more from
    - [ ] left
    - [x] right
  - [ ] showModalBottomSheet
  - [x] Locale
    - [x] plural
    - [x] mix
    - [x] number
  - [ ] protect key
  - [ ] gist
    - [ ] init
    - [ ] post
    - [ ] get
    - [ ] delete
  - [ ] purchase (Shopping cart)
  - [x] Social signin (firebase)
    - [x] id
    - [x] cache profile photo (for offline)
    - [x] google
    - [x] facebook

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(message),
    duration: Duration(milliseconds:500)
  )
);
