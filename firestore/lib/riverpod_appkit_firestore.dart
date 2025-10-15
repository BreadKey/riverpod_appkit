import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_appkit_repository/riverpod_appkit_repository.dart';

abstract class FirestorePagingRepository<T> implements PagingRepository<T> {
  final FirebaseFirestore firestore;
  final String orderBy;
  final String collectionPath;
  final FirestoreQueryBuilder queryBuilder;
  final FirestoreOrderValueGetter orderValueGetter;

  FirestorePagingRepository({
    required this.firestore,
    required this.orderBy,
    required this.collectionPath,
    required this.queryBuilder,
    required this.orderValueGetter,
  });

  T fromJson(DocumentSnapshot<Map<String, dynamic>> doc);

  @override
  Future<List<T>> load(
    int count, {
    String? afterId,
    bool descending = true,
  }) async {
    FirestoreQueryBuilder queryBuilder = OrderedQueryBuilder(
      firestore: firestore,
      builder: this.queryBuilder,
      orderBy: orderBy,
      descending: descending,
    );

    if (afterId != null) {
      queryBuilder = StartAfterQueryBuilder(
        firestore: firestore,
        builder: queryBuilder,
        value: await orderValueGetter.getOrderValue(afterId),
      );
    }

    queryBuilder = LimitQueryBuilder(
      firestore: firestore,
      builder: queryBuilder,
      limit: count,
    );

    final snapshot = await queryBuilder
        .buildQuery(firestore.collection(collectionPath))
        .get();

    return [
      ...snapshot.docs.map((doc) {
        return fromJson(doc);
      }),
    ];
  }

  Stream<T> changes() async* {
    await for (final snapshot
        in queryBuilder
            .buildQuery(firestore.collection(collectionPath))
            .snapshots()) {
      for (final change in snapshot.docChanges) {
        if (change.doc.data() != null) {
          yield fromJson(change.doc);
        }
      }
    }
  }
}

abstract class FirestoreOrderValueGetter {
  Future<Object?> getOrderValue(String id);
}

class DefaultOrderValueGetter extends FirestoreOrderValueGetter {
  final FirebaseFirestore firestore;
  final String collectionPath;
  final String orderField;

  DefaultOrderValueGetter({
    required this.firestore,
    required this.collectionPath,
    required this.orderField,
  });

  @override
  Future<Object?> getOrderValue(String id) async {
    return (await firestore.collection(collectionPath).doc(id).get())
        .data()![orderField];
  }
}

class SubCollectionOrderValueGetter extends FirestoreOrderValueGetter {
  final FirebaseFirestore firestore;
  final String subCollectionPath;
  final String parentCollectionPath;
  final String parentId;
  final String orderField;

  SubCollectionOrderValueGetter({
    required this.firestore,
    required this.subCollectionPath,
    required this.parentCollectionPath,
    required this.orderField,
    required this.parentId,
  });

  @override
  Future<Object?> getOrderValue(String id) async {
    return (await firestore
            .collection(parentCollectionPath)
            .doc(parentId)
            .collection(subCollectionPath)
            .doc(id)
            .get())
        .data()![orderField];
  }
}

abstract class FirestoreQueryBuilder {
  final FirebaseFirestore firestore;

  FirestoreQueryBuilder({required this.firestore});

  Query<Map<String, dynamic>> buildQuery(Query<Map<String, dynamic>> query);
}

abstract class QueryDecorator extends FirestoreQueryBuilder {
  final FirestoreQueryBuilder builder;

  QueryDecorator({required super.firestore, required this.builder});
}

class OrderedQueryBuilder extends QueryDecorator {
  final String orderBy;
  final bool descending;

  OrderedQueryBuilder({
    required super.firestore,
    required super.builder,
    required this.orderBy,
    required this.descending,
  });

  @override
  Query<Map<String, dynamic>> buildQuery(Query<Map<String, dynamic>> query) {
    return builder.buildQuery(query).orderBy(orderBy, descending: descending);
  }
}

class StartAfterQueryBuilder extends QueryDecorator {
  final Object? value;

  StartAfterQueryBuilder({
    required super.firestore,
    required super.builder,
    required this.value,
  });

  @override
  Query<Map<String, dynamic>> buildQuery(Query<Map<String, dynamic>> query) {
    return builder.buildQuery(query).startAfter([value]);
  }
}

class LimitQueryBuilder extends QueryDecorator {
  final int limit;

  LimitQueryBuilder({
    required super.firestore,
    required super.builder,
    required this.limit,
  });

  @override
  Query<Map<String, dynamic>> buildQuery(Query<Map<String, dynamic>> query) {
    return builder.buildQuery(query).limit(limit);
  }
}

class WhereQueryBuilder extends FirestoreQueryBuilder {
  final String where;
  final Object? isEqualTo;

  WhereQueryBuilder({
    required super.firestore,
    required this.where,
    required this.isEqualTo,
  });

  @override
  Query<Map<String, dynamic>> buildQuery(Query<Map<String, dynamic>> query) {
    return query.where(where, isEqualTo: isEqualTo);
  }
}

class WhereAndOrderedQueryBuilder extends QueryDecorator {
  final String orderBy;
  final String where;
  final Object? isEqualTo;
  final bool descending;

  WhereAndOrderedQueryBuilder({
    required super.firestore,
    required this.orderBy,
    required this.where,
    required this.isEqualTo,
    required this.descending,
  }) : super(
         builder: OrderedQueryBuilder(
           firestore: firestore,
           builder: WhereQueryBuilder(
             firestore: firestore,
             where: where,
             isEqualTo: isEqualTo,
           ),
           orderBy: orderBy,
           descending: descending,
         ),
       );

  @override
  Query<Map<String, dynamic>> buildQuery(Query<Map<String, dynamic>> query) {
    return builder.buildQuery(query);
  }
}

class SubcollectionQueryBuilder extends FirestoreQueryBuilder {
  final String subcollectionPath;
  final String parentId;

  SubcollectionQueryBuilder({
    required super.firestore,
    required this.subcollectionPath,
    required this.parentId,
  });

  @override
  Query<Map<String, dynamic>> buildQuery(Query<Map<String, dynamic>> query) {
    if (query is CollectionReference) {
      return (query as CollectionReference)
          .doc(parentId)
          .collection(subcollectionPath);
    }

    throw Exception("Query is not a CollectionReference");
  }
}

class ArrayContainsQueryBuilder extends FirestoreQueryBuilder {
  final String where;
  final Object? arrayContains;

  ArrayContainsQueryBuilder({
    required super.firestore,
    required this.where,
    required this.arrayContains,
  });

  @override
  Query<Map<String, dynamic>> buildQuery(Query<Map<String, dynamic>> query) {
    return query.where(where, arrayContains: arrayContains);
  }
}
