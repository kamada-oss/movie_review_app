require 'mail'

module Mail
  class UnstructuredField
    def encode_with_fix(value)
      encode_without_fix(value.encode(charset))
    end
    alias_method_chain :encode, :fix
  end

  class Message
    def charset=(value)
      @defaulted_charset = false
      @charset = value
      @header.charset = value
      @body.charset = value
    end
  end

  class Body
    def encoded_with_fix(transfer_encoding = '8bit')
      if multipart?
        encoded_without_fix(transfer_encoding)
      else
        be = get_best_encoding(transfer_encoding)
        dec = Mail::Encodings::get_encoding(encoding)
        enc = Mail::Encodings::get_encoding(be)
        if transfer_encoding == encoding and dec.nil?
          # Cannot decode, so skip normalization
          raw_source
        else
          # Decode then encode to normalize and allow transforming
          # from base64 to Q-P and vice versa
          enc.encode(dec.decode(raw_source).encode(charset))
        end
      end
    end
    alias_method_chain :encoded, :fix
  end
end