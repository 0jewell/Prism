local Types = require(script.Types)

local Data = require(script.Modules.Data)
local Clean = require(script.Modules.Clean)

local Registry = require(script.Registry)
export type Registry = Types.Registry
export type Entity = Types.Entity

local Query = require(script.Query)
export type Query<P... = ...any> = Types.Query<P...>

local Piece = require(script.Piece)
export type Piece<D = unknown> = Types.Piece<D>

export type Data  = Types.Data
export type UsedAs<D = never> = Types.UsedAs<D>

return table.freeze {
    Registry = Registry.New,
    Query = Query.New,
    Piece = Piece.New,

    from = Piece.from,

    MergeData = Data.merge,
    Clean = Clean,

    OnAdd = Piece.OnAdd,
    OnRemove = Piece.OnRemove,
    BuiltInPiece = Piece.BuiltInPiece
}