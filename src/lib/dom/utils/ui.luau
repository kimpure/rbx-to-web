export type Ui = {
	offset: number,
	scale: number,
}

local Ui = {}

function Ui.from_udim(udim: UDim): Ui
	return {
		offset = udim.Offset,
		scale = udim.Scale,
	}
end

Ui.zero = { offset = 0, scale = 0 } :: Ui

return Ui
