module PastelHelper
  def string_to_pastel(str)
    mkcolor(hash(str) % 0xFF, 240, 160).compact_hex
  end


  private def mkcolor(h, s, l)
    ColorMath::HSL.new(h.to_f / 0xFF, s.to_f / 0xFF, l.to_f / 0xFF)
  end

  private def hash(str)
    h = 0
    str.each_byte do |b|
      h += (b << 6) + (b << 16) - b;
    end
    h
  end
end
