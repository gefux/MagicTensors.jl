
function _phase_to_number(phase::UInt8)
    phase == 0x00 && return  1.0
    phase == 0x01 && return  0.0 + 1.0im
    phase == 0x02 && return  -1.0
    phase == 0x03 && return  0.0 - 1.0im
end

function _int_from_xz(x::Bool, z::Bool)
    i = nothing
    if !x && !z
        i = 0
    elseif x && !z
        i = 1
    elseif x && z
        i = 2
    elseif !x && z
        i = 3
    end
    return i
end
