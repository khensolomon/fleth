# Reference

## Card

```dart
Material(
  color: Theme.of(context).primaryColor,
  shape: RoundedRectangleBorder(
  side: BorderSide(
    color: Theme.of(context).shadowColor,
    width: 0.5,
  ),
  // borderRadius: BorderRadius.circular(10),
);

Card();

Container(
  margin: const EdgeInsets.fromLTRB(0, 3, 0, 5),
  decoration: BoxDecoration(
    color: Theme.of(context).primaryColor,
    border: Border.symmetric(
      horizontal: BorderSide(
        width: 1,
        color: Theme.of(context).shadowColor,
      ),
    ),
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).shadowColor,
        offset: const Offset(0.0, 0.0),
        blurRadius: 0.2,
        spreadRadius: 0.3,
      ),
    ],
  ),
  child: null,
);
```

## ScaffoldMessenger

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(message),
    duration: Duration(milliseconds:500)
  )
);
