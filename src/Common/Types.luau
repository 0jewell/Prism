export type Cleaning =
    Instance
    | RBXScriptConnection
    | () -> ()
    | { destroy: (unknown) -> () }
    | { Destroy: (unknown) -> () }
    | { Cleaning }
    | thread

export type Piece<D = unknown> = {
    data: D,
}

export type Entity = number

export type UsedAs<D = unknown> = Entity | Piece<D>

export type Word = number
export type Mask = number

export type BitMap = { [Word]: Mask }

export type Record = {
    word: Word,
    mask: Mask
}

export type Priority = number

export type QuerySettings<P...> = {
    query: () -> P...,
    priority: number?
}

export type Trait<P...> = (Data, P...) -> ()

export type TraitRecord<P...> = {
    trait: Trait<P...>,
    name: string
}

export type Data = {
    registry: Registry,
    entity: Entity,
    cleaning: { Cleaning }
}

export type Query<P... = ...any> = typeof(setmetatable({} :: QueryFields<P...>, {} :: QueryImpl<P...>))

type QueryFields<P...> = {
    traits: { TraitRecord<P...> },
    settings: QuerySettings<P...>
}

type QueryImpl<P...> = {
    __index: QueryImpl<P...>,
    New: (settings: QuerySettings<P...>) -> Query<P...>,
    trait: (self: Query<P...>, name: string, trait: (Data, P...) -> ()) -> Query<P...>
}

export type Registry = typeof(setmetatable({} :: RegistryFields, {} :: RegistryImpl))

type RegistryFields = {
    nextId: number,
    size: number,
    cachedPieces: { [Piece]: Entity },
    entityRecords: { [Entity]: Record },
    bitMaps: { [Entity]: BitMap },
    storage: { [Entity]: { [Entity]: Piece<any> } },
    queryStorage: { [Priority]: { Query } },
    queryMaps: { [Query]: BitMap },
    consumedQueries: { [Query]: { [Entity]: Cleaning } }
}

type RegistryImpl = {
    __index: RegistryImpl,
    New: () -> Registry,
    entity: (self: Registry) -> Entity,
    entityAt: (self: Registry, at: number) -> Entity,
    cast: (self: Registry, ...UsedAs) -> ...Entity,
    pair: (self: Registry, relation: UsedAs, target: UsedAs) -> Entity,
    include: (self: Registry, queries: { Query }) -> (),
    match: (self: Registry, entity: UsedAs) -> (),
    add: <D>(self: Registry, entity: UsedAs, piece: UsedAs<D>, data: D?) -> D?,
    remove: (self: Registry, entity: UsedAs, piece: UsedAs) -> (),
    delete: (self: Registry, entity: UsedAs) -> (),
    contains: (self: Registry, entity: UsedAs, ...UsedAs) -> boolean,
    ask: <D>(self: Registry, entity: UsedAs, piece: UsedAs<D>) -> Piece<D>?
}

return {}