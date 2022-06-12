part of matan.collection;

/// A collection whose contents will never change, which offers some guarnatees.
///
/// This class and related classes are inspired by Java's [Guava](https://guava.dev/releases/20.0/api/docs/com/google/common/collect/ImmutableCollection.html).
///
/// **WARNING**: Avoid _direct_ usage of [ImmutableCollection] as a type;
/// instead prefer subtypes such as [ImmutableList], which have well-defined
/// `==` and `hashCode` semnantics, thus avoiding a common source of bugs and
/// confusion.
///
/// ## Guarantees
///
/// Classes which implement [ImmutableCollection] **must guarantee**:
///
/// - **Shallow immutability**. Elements can never be added, removed, or
///   replaced in this collection. This is a stronger guarantee than that of
///   [UnmodifiableListView], whose contents change whenever the wrapped
///   collection is modified.
/// - **Deterministic iteration**. The iteration order is always well-defined,
///   depending on how the collection was created. View collections must iterate
///   in the same order as the parent, except as noted.
/// - **Integrity**. This type cannot be sub-classed outside of this package
///   (which would allow these guarantees to be violated).
///
/// ## "Interfaces", not implementations
///
/// Each public class, such as [ImmutableList], is a _type_ offering meaningful
/// behavioral guarantees. You should treat them as interfaces in every
/// important sense of the word.
///
/// For field types and method return types, you should genreally use the
/// immutable type (such as [ImmutableList]) instead of the general collection
/// interface type (such as [List]). This communicates to your callers all of
/// the semantic guarantees listed above, which is almost alwayts very useful
/// information.
///
/// On the other hand, a _parameter_ of [ImmutableList] is generally a
/// nuisance to callers. Instead, accept [Iterable] and have your method or
/// constructor make a shallow copy of the elements themselves.
///
/// ## Creation
///
/// Except for logically "abstract" types (like [ImmutableCollection] itself),
/// each immutable collection provides the static operations you need to obtain
/// instances of that type. These usually include:
///
/// - Default constructors, copying an existing collection of elements.
/// - Named `of` constructors, accepting an explicit list of elements.
/// - A paired `Builder` class which can be used to populate a new instance.
///
/// ## Performance notes
///
/// - Implementations can be generally assumed to prioritize memory efficiency,
///   then speed of access, and lastly speed of creation, unless otherwise
///   specified.
/// - The default constructor will _sometimes_ recognize that the actual copy
///   operation is unnecessary; for example `ImmutableList(immutableList)` may
///   use the existing backing collection. However, the precise conditions for
///   skipping copy operations are intentionally undefined.
/// - **WARNING**: A view collection (i.e. `sublist`) may retain a reference to
///   the entire data set, preventing it from being garbage collected. If some
///   of the data is no longer reachable through other means, this constitutes
///   a memory leak. Instead, make a copy of the underlying elements if able.
/// - The peformance of using the associated `Builder` class can be assumed to
///   be no worse, and possibly better, than creating a mutable collection and
///   copying it.
/// - Implementations generally do not cache hash codes. If your element or key
///   type has a slow `hashCode` implementation, it should cache it itself or
///   consider using a wrapper class.
@immutable
@sealed
abstract class ImmutableCollection<T> extends Iterable<T> {
  const ImmutableCollection._();

  /// Creates a mutable copy of the current collection as a builder.
  @useResult
  ImmutableCollectionBuilder<T> toBuilder();
}

/// Abstract base class for builders of [ImmutableCollection] types.
///
/// Builder instances can be reused; it is safe to call [build] multiple times
/// unless otherwise specified. Each new collection contains all the elements of
/// the ones created before it.
@sealed
abstract class ImmutableCollectionBuilder<T> {
  /// Adds [element] to the [ImmutableCollection] being built.
  ImmutableCollectionBuilder<T> add(T element);

  /// Adds each of [elements] to the [ImmutableCollection] being built.
  ImmutableCollectionBuilder<T> addAll(Iterable<T> elements) {
    for (final element in elements) {
      add(element);
    }
    return this;
  }

  /// Returns a newly-created [ImmutableCollection] of the appropriate type.
  @factory
  ImmutableCollection<T> build();
}
