// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stars.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserStarsCollection on Isar {
  IsarCollection<UserStars> get userStars => this.collection();
}

const UserStarsSchema = CollectionSchema(
  name: r'UserStars',
  id: 2764006903836876124,
  properties: {
    r'goldStars': PropertySchema(
      id: 0,
      name: r'goldStars',
      type: IsarType.long,
    ),
    r'greenStars': PropertySchema(
      id: 1,
      name: r'greenStars',
      type: IsarType.long,
    )
  },
  estimateSize: _userStarsEstimateSize,
  serialize: _userStarsSerialize,
  deserialize: _userStarsDeserialize,
  deserializeProp: _userStarsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userStarsGetId,
  getLinks: _userStarsGetLinks,
  attach: _userStarsAttach,
  version: '3.1.0+1',
);

int _userStarsEstimateSize(
  UserStars object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _userStarsSerialize(
  UserStars object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.goldStars);
  writer.writeLong(offsets[1], object.greenStars);
}

UserStars _userStarsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserStars(
    goldStars: reader.readLong(offsets[0]),
    greenStars: reader.readLong(offsets[1]),
  );
  object.id = id;
  return object;
}

P _userStarsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userStarsGetId(UserStars object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userStarsGetLinks(UserStars object) {
  return [];
}

void _userStarsAttach(IsarCollection<dynamic> col, Id id, UserStars object) {
  object.id = id;
}

extension UserStarsQueryWhereSort
    on QueryBuilder<UserStars, UserStars, QWhere> {
  QueryBuilder<UserStars, UserStars, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserStarsQueryWhere
    on QueryBuilder<UserStars, UserStars, QWhereClause> {
  QueryBuilder<UserStars, UserStars, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserStarsQueryFilter
    on QueryBuilder<UserStars, UserStars, QFilterCondition> {
  QueryBuilder<UserStars, UserStars, QAfterFilterCondition> goldStarsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goldStars',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition>
      goldStarsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goldStars',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition> goldStarsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goldStars',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition> goldStarsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goldStars',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition> greenStarsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'greenStars',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition>
      greenStarsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'greenStars',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition> greenStarsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'greenStars',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition> greenStarsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'greenStars',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserStarsQueryObject
    on QueryBuilder<UserStars, UserStars, QFilterCondition> {}

extension UserStarsQueryLinks
    on QueryBuilder<UserStars, UserStars, QFilterCondition> {}

extension UserStarsQuerySortBy on QueryBuilder<UserStars, UserStars, QSortBy> {
  QueryBuilder<UserStars, UserStars, QAfterSortBy> sortByGoldStars() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goldStars', Sort.asc);
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterSortBy> sortByGoldStarsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goldStars', Sort.desc);
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterSortBy> sortByGreenStars() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'greenStars', Sort.asc);
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterSortBy> sortByGreenStarsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'greenStars', Sort.desc);
    });
  }
}

extension UserStarsQuerySortThenBy
    on QueryBuilder<UserStars, UserStars, QSortThenBy> {
  QueryBuilder<UserStars, UserStars, QAfterSortBy> thenByGoldStars() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goldStars', Sort.asc);
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterSortBy> thenByGoldStarsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goldStars', Sort.desc);
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterSortBy> thenByGreenStars() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'greenStars', Sort.asc);
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterSortBy> thenByGreenStarsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'greenStars', Sort.desc);
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserStars, UserStars, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension UserStarsQueryWhereDistinct
    on QueryBuilder<UserStars, UserStars, QDistinct> {
  QueryBuilder<UserStars, UserStars, QDistinct> distinctByGoldStars() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goldStars');
    });
  }

  QueryBuilder<UserStars, UserStars, QDistinct> distinctByGreenStars() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'greenStars');
    });
  }
}

extension UserStarsQueryProperty
    on QueryBuilder<UserStars, UserStars, QQueryProperty> {
  QueryBuilder<UserStars, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserStars, int, QQueryOperations> goldStarsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goldStars');
    });
  }

  QueryBuilder<UserStars, int, QQueryOperations> greenStarsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'greenStars');
    });
  }
}
