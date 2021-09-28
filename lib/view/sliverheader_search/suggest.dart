part of 'main.dart';

mixin _Suggest on _State {

  Widget suggest(){

    return Selector<Core,String>(
      selector: (_, e) => e.searchQuery,
      builder: (BuildContext context,String query, Widget? child) {
        // return Text('suggestion: $query');
        return ListView(
          primary: false,
          shrinkWrap: true,
          children: [
            Text('suggestion: $query'),
            suggestListView()
          ],
        );
      }
    );
  }

  Widget suggestListView(){
    return ListView.separated(
      itemCount: 25,
      primary: false,
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        final delayedMilliseconds = 320 * (index % 25 + 1);
        // const delayedMilliseconds = 300;
        return FutureBuilder<bool>(
          future: Future.delayed(Duration(milliseconds:delayedMilliseconds), ()=>true),
          builder: (_, AsyncSnapshot<bool> snap){
            if (snap.hasData == false) return const SizedBox(height: 50,);
            return ListTile(
              title: Text('suggestion index: $index delayedMilliseconds: $delayedMilliseconds'),
            );
          }
        );
      },
    );
  }
}
