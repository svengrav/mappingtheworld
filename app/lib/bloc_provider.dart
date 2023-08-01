// import 'package:flutter/material.dart';

// abstract class Disposable {
//   void dispose();
// }

// class StreamProvider<T extends Disposable> extends StatefulWidget {
//   final Widget child;
//   final T source;

//   const StreamProvider({
//     Key? key,
//     required this.source,
//     required this.child,
//   }) : super(key: key);

//   // 2
//   static T of<T extends Disposable>(BuildContext context) {
//     final StreamProvider<T> provider = context.findAncestorWidgetOfExactType()!;
//     return provider.source;
//   }

//   @override
//   State createState() => _StreamProviderState();
// }

// class _StreamProviderState extends State<StreamProvider> {
//   // 3
//   @override
//   Widget build(BuildContext context) => widget.child;

//   // 4
//   @override
//   void dispose() {
//     widget.source.dispose();
//     super.dispose();
//   }
// }


// class BlocBuilder<T extends Disposable> extends StatelessWidget {
//   const BlocBuilder({super.key});

//   @override
//   Widget build(BuildContext context) {

//       final bloc = StreamProvider.of<T>(context);

//       return StreamBuilder<T>(
//     stream: bloc.articlesStream,
//     builder: (context, snapshot) {
//       // 2
//       final results = snapshot.data;
//       if (results == null) {
//         return const Center(child: Text('Loading ...'));
//       } else if (results.isEmpty) {
//         return const Center(child: Text('No Results'));
//       }
//       // 3
//       return _buildSearchResults(results);
//     },
//   );



//   }
// }