%stupne z minut vterin na desetinny
function[uhel] = dms2deg(stupne,minuty,vteriny)
uhel = stupne + minuty/60 + vteriny/3600;
end

